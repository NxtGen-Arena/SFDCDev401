public virtual class TriggerHandler {

  // static map of handlername, times run() was invoked
  private static Map<String, LoopCount> loopCountMap;
  private static Set<String> bypassedHandlers;

  // the current context of the trigger, overridable in tests
  @TestVisible
  private TriggerContext context;

  // the current context of the trigger, overridable in tests
  @TestVisible
  private Boolean isTriggerExecuting;

  // static initialization
  static {
    loopCountMap = new Map<String, LoopCount>();
    bypassedHandlers = new Set<String>();
  }
  
  // constructor
  public TriggerHandler() {
    this.setTriggerContext();
  }

  /***************************************
   * public instance methods
   ***************************************/

  // main method that will be called during execution
  /**
   * @description This is main method called by trigger.
   * @Purpose Determining the context for trigger and calling the correct handler method
   */
  public void run() {

    if(!validateRun()) {
      return;
    }

    addToLoopCount();

    // dispatch to the correct handler method
    switch on this.context {
      when BEFORE_INSERT {
        this.beforeInsert();
      }
      when BEFORE_UPDATE {
        this.beforeUpdate();
      }
      when BEFORE_DELETE {
        this.beforeDelete();
      }
      when AFTER_INSERT {
        this.afterInsert();
      }
      when AFTER_UPDATE {
        this.afterUpdate();
      }
      when AFTER_DELETE {
        this.afterDelete();
      }
      when AFTER_UNDELETE {
        this.afterUndelete();
      }
    }
  }

  /**
   * @description Allows to prevent recursive trigger loops or allows a limited number of executions
   * if the execution limit is reached throws an exception
   * @param max The maximum number of times the trigger should loop. If negative, no limit is set
   * @example this.setMaxLoopCount(2);
   */
  public void setMaxLoopCount(Integer max) {
    String handlerName = getHandlerName();
    if(!TriggerHandler.loopCountMap.containsKey(handlerName)) {
      TriggerHandler.loopCountMap.put(handlerName, new LoopCount(max));
    } else {
      TriggerHandler.loopCountMap.get(handlerName).setMax(max);
    }
  }

  /**
   * @description turn off the max loop count
   */

  public void clearMaxLoopCount() {
    this.setMaxLoopCount(-1);
  }

  /***************************************
   * public static methods
   ***************************************/

  /**
   * @description conditionally bypass (diable) triggers that implement the triggerHandler
   * @param handlerName class name of the trigger handler to bypass
   */
  public static void bypass(String handlerName) {
    TriggerHandler.bypassedHandlers.add(handlerName);
  }

  /**
   * @description clear the conditionally bypassed (diable) triggers that implement the triggerHandler
   * @param handlerName class name of the trigger handler to bypass
   */
  public static void clearBypass(String handlerName) {
    TriggerHandler.bypassedHandlers.remove(handlerName);
  }

  /**
   * @description check whether a given trigger handler class is currently bypassed
   * @param handlerName class name of the trigger handler to bypass
   */
  public static Boolean isBypassed(String handlerName) {
    return TriggerHandler.bypassedHandlers.contains(handlerName);
  }

  public static void clearAllBypasses() {
    TriggerHandler.bypassedHandlers.clear();
  }

  /***************************************
   * private instancemethods
   ***************************************/

  @TestVisible
  private void setTriggerContext() {
    this.setTriggerContext(null, false);
  }

  /**
   * @description setting the trigger context
   * @param ctx the context of the trigger
   * @param testMode is the trigger running in a test context
   * */

  @TestVisible
  private void setTriggerContext(String ctx, Boolean testMode) {
    if(!Trigger.isExecuting && !testMode) {
      this.isTriggerExecuting = false;
      return;
    } else {
      this.isTriggerExecuting = true;
    }

   /* if(Trigger.isExecuting && !istestMode) {
      switch on Trigger.operationType {
        when BEFORE_INSERT {
          this.context = TriggerContext.BEFORE_INSERT;
        }
        when BEFORE_UPDATE {
          this.context = TriggerContext.BEFORE_UPDATE;
        }
        when BEFORE_DELETE {
          this.context = TriggerContext.BEFORE_DELETE;
        }
        when AFTER_INSERT {
          this.context = TriggerContext.AFTER_INSERT;
        }
        when AFTER_UPDATE {
          this.context = TriggerContext.AFTER_UPDATE;
        }
        when  AFTER_DELETE {
          this.context = TriggerContext.AFTER_DELETE;
        }
        when AFTER_UNDELETE {
          this.context = TriggerContext.AFTER_UNDELETE;
        }
      }
    } else if(ctx != null && testMode) {
      switch on ctx {
         when 'before insert' {
          this.context = TriggerContext.BEFORE_INSERT;
        }
        when 'before update' {
          this.context = TriggerContext.BEFORE_UPDATE;
        }
        when 'before delete' {
          this.context = TriggerContext.BEFORE_DELETE;
        }
        when 'after insert' {
          this.context = TriggerContext.AFTER_INSERT;
        }
        when 'after update' {
          this.context = TriggerContext.AFTER_UPDATE;
        }
        when  'after delete' {
          this.context = TriggerContext.AFTER_DELETE;
        }
        when 'after undelete' {
          this.context = TriggerContext.AFTER_UNDELETE;
        }
        when else {
          throw new TriggerHandler.TriggerHandlerException (
            'Unexpected trigger context set'
          );
        }
      }
    }*/

    //setting the trigger context event
    if((Trigger.isExecuting && Trigger.isBefore && Trigger.isInsert) ||
        (ctx != null && ctx == 'before insert')) {
      this.context = TriggerContext.BEFORE_INSERT;
    } else if((Trigger.isExecuting && Trigger.isBefore && Trigger.isUpdate) ||
        (ctx != null && ctx == 'before update')){
      this.context = TriggerContext.BEFORE_UPDATE;
    } else if((Trigger.isExecuting && Trigger.isBefore && Trigger.isDelete) ||
        (ctx != null && ctx == 'before delete')) {
      this.context = TriggerContext.BEFORE_DELETE;
    } else if((Trigger.isExecuting && Trigger.isAfter && Trigger.isInsert) ||
        (ctx != null && ctx == 'after insert')) {
      this.context = TriggerContext.AFTER_INSERT;
    } else if((Trigger.isExecuting && Trigger.isAfter && Trigger.isUpdate) ||
        (ctx != null && ctx == 'after update')) {
      this.context = TriggerContext.AFTER_UPDATE;
    } else if((Trigger.isExecuting && Trigger.isAfter && Trigger.isDelete) ||
        (ctx != null && ctx == 'after delete')) {
      this.context = TriggerContext.AFTER_DELETE;
    } else if((Trigger.isExecuting && Trigger.isAfter && Trigger.isUndelete) ||
        (ctx != null && ctx == 'after undelete')) {
      this.context = TriggerContext.AFTER_UNDELETE;
    }
  }

  // increment the loop count
  @TestVisible
  private void addToLoopCount() {
    String handlerName = getHandlerName();
    if(TriggerHandler.loopCountMap.containsKey(handlerName)) {
      Boolean exceeded = TriggerHandler.loopCountMap.get(handlerName).increment();
      if(exceeded) {
        Integer max = TriggerHandler.loopCountMap.get(handlerName).max;
        throw new TriggerHandlerException('Maximum loop count of ' + String.valueOf(max) + ' reached in ' + handlerName);
      }
    }
  }

  // make sure this trigger should continue to run
  @TestVisible
  private Boolean validateRun() {
    if(!this.isTriggerExecuting || this.context == null) {
      throw new TriggerHandlerException('Trigger handler called outside of Trigger execution');
    }
    return !TriggerHandler.bypassedHandlers.contains(getHandlerName());
  }

  /**
   * @description returns the string version of the handler class being invoked
   * @return the handler name
   */
  @TestVisible
  private String getHandlerName() {
    return this.toString().substringBefore(':');
  }

  /***************************************
   * context methods
   ***************************************/

  // context-specific methods for override
  /**
   * These methods are all intented to be overridden by 
   * individual trigger handlers implementing. They are contractual binding here.
   */
  @TestVisible
  protected virtual void beforeInsert(){}
  @TestVisible
  protected virtual void beforeUpdate(){}
  @TestVisible
  protected virtual void beforeDelete(){}
  @TestVisible
  protected virtual void afterInsert(){}
  @TestVisible
  protected virtual void afterUpdate(){}
  @TestVisible
  protected virtual void afterDelete(){}
  @TestVisible
  protected virtual void afterUndelete(){}

  /***************************************
   * inner classes
   ***************************************/

  // inner class for managing the loop count per handler
  @TestVisible
  private class LoopCount {
    private Integer max;
    private Integer count;

    public LoopCount() {
      this.max = 5;
      this.count = 0;
    }

    public LoopCount(Integer max) {
      this.max = max;
      this.count = 0;
    }

    public Boolean increment() {
      this.count++;
      return this.exceeded();
    }

    public Boolean exceeded() {
      return this.max >= 0 && this.count > this.max;
    }

    public Integer getMax() {
      return this.max;
    }

    public Integer getCount() {
      return this.count;
    }

    public void setMax(Integer max) {
      this.max = max;
    }
  }

  // possible trigger contexts
  @TestVisible
  private enum TriggerContext {
    BEFORE_INSERT, BEFORE_UPDATE, BEFORE_DELETE,
    AFTER_INSERT, AFTER_UPDATE, AFTER_DELETE,
    AFTER_UNDELETE
  }

  // custom exception class
  public class TriggerHandlerException extends Exception {}

}
