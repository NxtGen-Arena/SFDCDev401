# Payment Processing System

<p>

- StayEase Hotel accepts multiple modes of payment:Credit Card,UPI, PayPal,Corporate Voucher etc
- Each payment type:
- ** has its own integration,
- ** has different validations,
- ** but must follow common steps (validate → process → update booking).

This leads to code duplication, inconsistency, and tight coupling.
<img width="800" height="400" alt="image" src="https://github.com/user-attachments/assets/fde06610-ac95-453c-99c3-f1803802d282" />
</p>

<h2>Architecture Pattern: Strategy Pattern </h2>

```
PaymentService → chooses strategy (CreditCard, UPI, PayPal)
Each Strategy class → has its own implementation
Interface → ensures all strategies follow the same steps
```

</p>

<p>List of Classes</p>

|Class Name| Purpose|
|----------|--------|
|IPaymentProcessor|This interface is a blueprint.Any class that implements it must provide the logic for validation, processing, and updating booking.|
|CreditCardPayment| Implements IPaymentProcessor. Contains the logic is specific to a Credit Card.|
