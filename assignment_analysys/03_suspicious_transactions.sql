SELECT accountid, companyid, amount, created, direction, status
FROM transactions
WHERE amount > 50000  -- Detect large amounts
  AND (direction = 'Outgoing' OR direction = 'Incoming')  -- Include both directions
ORDER BY created DESC;


/*What Happened?
I found two large transactions involving the same account (97046bf5-5090-4691-99d9-fe589f765bbd, belonging to Company1):

€66,215 was received on April 30, 2024, at 11:55 AM (Incoming transaction) from IBAN: BGIban1.
Just 3 minutes later, €66,000 was sent out at 11:58 AM (Outgoing transaction) to IBAN: DEIban1.
The fact that money came in and immediately went out is a strong red flag for money laundering or fraudulent fund movement.

What’s the Issue?
🔴 Why is this suspicious?

The timing is too fast

Money was received and then sent within 3 minutes.
Legitimate businesses don’t usually move large sums this quickly unless they are a financial intermediary (e.g., a bank).
Different IBANs for sending and receiving money

Money came from BGIban1 and went to DEIban1, which suggests this account is just moving funds rather than using them.
This pattern is typical of money laundering (layering stage).
The amounts are almost identical

€66,215 received → €66,000 sent out.
Only €215 remained in the account, meaning this account isn't holding money, just passing it along.
Completed status

Both transactions were successfully processed, meaning the money is already gone.
How I Found It?
1.Updated the SQL query to detect both large incoming and outgoing transactions
2.This showed both the €66,215 incoming and €66,000 outgoing transactions for the same account.
3.Checked if the IBANs (BGIban1, DEIban1) appear in other suspicious transactions.

How to Stop This in The Future?
✅ Monitor rapid incoming and outgoing transactions

Flag accounts that receive and send large amounts within a short time.
✅ Investigate IBANs involved in large fund movements

If an IBAN keeps appearing in suspicious transactions, it may belong to a money mule or shell company.
✅ Require additional verification for high-value transactions

If an account moves more than €50,000 within minutes, require manual approval or additional checks.
✅ Check for repeating patterns

If this same account does this regularly, it’s likely part of a fraud network.
Final Verdict: HIGHLY SUSPICIOUS 🚩
Yes, this is very likely money laundering.
Yes, the €66,215 incoming transaction is suspicious.
Yes, this account should be investigated further.*/