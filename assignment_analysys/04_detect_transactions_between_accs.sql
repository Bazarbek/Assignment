SELECT t1.accountid AS sender, t2.accountid AS receiver, 
       t1.amount AS sent_amount, t2.amount AS received_amount,
       t1.created AS sent_time, t2.created AS received_time
FROM transactions t1
JOIN transactions t2
  ON t1.accountid = t2.accountid  -- Matches transactions from the same account
  AND t1.direction = 'Outgoing'
  AND t2.direction = 'Incoming'
  AND t2.created <= t1.created  -- Incoming transaction must happen before outgoing
  AND ABS(t1.amount - t2.amount) <= 500  -- Allow small differences in transaction amounts
  AND t1.created BETWEEN t2.created AND t2.created + INTERVAL '10 minutes'  -- Time constraint
ORDER BY t1.created DESC;

/*What Happened?
I found a suspicious transaction pattern in which money was received and then quickly sent out within 3 minutes.

Key Events Leading to This Conclusion:

€66,215 was received by Company1 (Account ID: 97046bf5-5090-4691-99d9-fe589f765bbd) on April 30, 2024, at 11:55 AM.
€66,000 was sent out from the same account just 3 minutes later, at 11:58 AM.
The amounts are almost identical, with only a €215 difference.
These are classic signs of money laundering, where funds are rapidly moved to hide their origin.

What’s the Issue?
🚩 Why is This Suspicious?

Fast movement of funds (3 minutes between transactions)

Legitimate businesses don’t usually receive and send large amounts within minutes.
Fraudsters use quick transactions to avoid detection.
Same account received and sent money

Instead of keeping the funds, this account immediately transferred almost the same amount out.
This makes it look like a "pass-through" or mule account.
Amounts are nearly identical (€66,215 received → €66,000 sent)

When fraudsters transfer money, they sometimes leave behind only a small fraction to avoid raising red flags.
The €215 difference is too small for a normal business transaction.

How I Found It?
1.Updated the SQL Query to detect transactions where:

-Money comes in and goes out within 10 minutes.
-Amounts are similar (within €500 difference).
-Transactions are linked to the same account instead of just correlation IDs.

2.Analyzed the transaction timestamps
Confirmed that the outgoing transaction happened within 3 minutes of the incoming one.

3.Compared transaction amounts

Only a €215 difference between what was received and sent, which is unusual.
How to Prevent This in the Future?
✅ Monitor transactions where money is sent out quickly after being received

Flag any account that moves large amounts within minutes.
✅ Investigate accounts that send out nearly the same amount they receive

Normal businesses don’t immediately send out 99% of incoming funds.
✅ Set alerts for large transactions with small remaining balances

If an account only keeps a small amount (€215 in this case), it could be a fraud pass-through account.
✅ Analyze IBANs used in these transactions

If the same IBANs appear in multiple suspicious transactions, they could belong to a fraud network.
🚀 Final Verdict: HIGHLY SUSPICIOUS! Immediate Review Needed!
Yes, this account is very likely involved in money laundering.
Yes, the transactions should be flagged and investigated.
Yes, this account should be monitored for further suspicious activity.*/