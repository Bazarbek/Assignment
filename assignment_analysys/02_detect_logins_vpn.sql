SELECT identity, email, ips, providers
FROM accounts_activity
WHERE providers LIKE '%M247%'
   OR providers LIKE '%31173%'
ORDER BY identity, start_time DESC;

/*What Happened
When checking the logs, i noticed some users were logging in using VPNs, which is usually a red flag. VPNs hide the real location of a user, and fraudsters love using them to bypass security checks.

Company1 (EMAIL1) logged in using M247 Europe and 31173 Services AB, both are well-known VPN providers.
Company2 (EMAIL2) also used M247 Europe, which is a bit suspicious too.
This means we can’t trust the location data for these users. They could be logging in from anywhere.

Why Is This a Problem?
🔴 Why do fraudsters use VPNs?

To hide their real identity – They don’t want you to know where they really are.
To get around security rules – If a company blocks logins from high-risk countries, a fraudster can use a VPN to pretend they’re logging in from somewhere safe.
To make tracking harder – Every login comes from a new location, making it difficult to connect fraudulent activity to one user.
🔍 What the data shows:

I ran a query to find logins that used VPN providers like M247 or 31173.
Company1 was the worst offender – They used both VPN providers multiple times.
Company2 used M247, which is not as bad but still suspicious.

How I Found It
Filtered logs to see who logged in using VPNs
Checked if these users had suspicious transactions or behavior
Looked at whether they used different VPNs at different times, which makes them even more suspicious.

How to Stop This in The Future?
✅ Block VPN logins – Many fraud prevention systems can detect when an IP belongs to a VPN.
✅ Require extra verification for VPN users – If someone logs in using a VPN, make them enter a security code or answer a security question.
✅ Look for sudden VPN use – If a user was always logging in normally but suddenly starts using a VPN, flag it as risky.
✅ Track login locations – If a user logs in from a real location sometimes and a VPN at other times, investigate their activity.

If VPN-based fraud gets blocked, it’s much harder for scammers to hide their real identity or bypass security rules.

*/