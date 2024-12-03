# Naming Conventions in Apex

---
> Any fool can write code that a computer can understand. Good programmers write code that humans can understand.
>
> -- Martin Fowler

## Why Naming Conventions are Important?

  1. Self-Documentation – Meaningful names self-document your code. Clean code is like a story that you can read and follow. Appropriate variable naming helps avoid the need for comments.
  2. Consistency – Naming conventions should be consistent across the whole project. Developers know what to expect, which can aid in understanding and debugging.
  3. Readability and Understandability – Code is for humans, not machines. We understand the code we create, but we should also consider developers who will maintain our code later. A clear naming     
      convention reduces confusion and facilitates logical understanding.
  4. Maintainability – Modifications are easier to make in code we understand. Even if the code is not working, but you can understand it, you can also fix it.
     


## Best Practice
1. Use Intention-Revealing Name – Ensure that each name answers critical questions: why does it exist, what is its purpose, and how is it utilized?
2. Avoid Disinformation – Steer clear of names that may lead to confusion and misinterpretation. Avoid ambiguity. 
3. Make Meaningful Distinctions – Clarify the distinctions between terms, for instance, differentiate between name and nameString, or between accounts and accountList. Simplify variable names by eliminating
   unnecessary words such as the, String, or List. 
4. Use Pronounceable Names – As stated by the quote, "If you can’t pronounce it, you can’t discuss it without sounding like an idiot" [1]. Opt for names that are easy to pronounce, facilitating effective
   communication and code explanation.
5. Use Searchable Names – Avoid the use of magic numbers that may confuse. Instead, employ final or const variables to explicitly convey your intentions, such as `const WORK_DAYS_PER_WEEK = 5;
6. Pick One Word per Concept – particularly crucial in Apex programming, adhering to the principle of using one word per concept. Maintain consistency, for example, with names like AccountSelector and
   ContactSelector for services and utility classes.
7. Add Meaningful Context – Provide contextual clarity, especially in classes. For instance, the state variable in the Address class should represent something distinct from the state variable in the
   Shipping class.
8. Use Boolean variable names that imply true or false - isExecutable(). Use positive Boolean names. Use isActive rather than isInactive.


![image](https://github.com/user-attachments/assets/a1b16f1b-b43a-435b-8229-dfa4e986cc16)


![image](https://github.com/user-attachments/assets/9f524f4c-2e8c-4657-9de0-474911c537b7)
