SELECT identity, email, COUNT(DISTINCT ips) AS unique_ips, COUNT(*) AS login_attempts
FROM accounts_activity
GROUP BY identity, email
HAVING COUNT(DISTINCT ips) > 2  -- Use COUNT(DISTINCT ips) directly
ORDER BY unique_ips DESC;


/*What’s the Issue?
🔴 Why is this a problem?

If an account logs in from many IPs, it might mean different people are using it. Maybe they’re sharing credentials, or a hacker got in.
When users log in from different places quickly, it’s often because they’re using a VPN or a fraudster is trying to break in.
More login attempts also means higher risk of brute force attacks (where hackers try to guess passwords).
🔍 What the data shows:

The SQL query counted how many different IPs each user had.
We focused on accounts with more than 2 unique IPs because, usually, people don’t use more than that.
Company1’s 23 IPs? Definitely suspicious.

1. Used SQL to count unique IPs per user
sql
2. Checked the accounts that had way too many IPs
3. Looked at their login patterns to see if they used a VPN or switched locations fast.


How to Stop This in The Future?
✅ Enable Two-Factor Authentication (2FA) – If someone’s password gets stolen, this adds another layer of security.
✅ Alert users when a login happens from a new location or device. – They can confirm if it was them or not.
✅ Limit the number of devices per user. – If an account is suddenly logging in from 10+ IPs, block it or ask for extra verification.
✅ Detect & block unusual login locations. – If a user logs in from Russia, then Spain, then the US in 5 minutes, that’s super weird.

If these things are in place, it’s way harder for fraudsters to take over accounts or share access in shady ways.*/