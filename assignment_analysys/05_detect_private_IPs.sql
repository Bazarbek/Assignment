SELECT identity, email, ips, city, country
FROM accounts_activity
WHERE ips LIKE '192.168.%'  -- Private network
   OR ips LIKE '10.%'
   OR ips LIKE '172.16.%'
ORDER BY start_time DESC;

/*What Happened?
I detected a suspicious login from a private/internal network (192.168.x.x), which is not accessible from the public internet.

Key Events Leading to This Conclusion:

Company2 (EMAIL2) logged in from 192.168.0.1 on April 1, 2024, at 17:50:58.
The network is listed as 192.168.0.0/19, which is a private/internal network.
The provider field is empty (-), meaning it was not routed through a public ISP.
The city and country fields are empty (-), suggesting that this login didn’t come from an external internet connection.
What’s the Issue?

🚩 Why is This Suspicious?

Private IPs (192.168.x.x, 10.x.x, 172.16.x.x) are used in internal networks only

These addresses are not assigned to public internet users.
This means the login happened from within the system’s internal network or through a misconfigured VPN.
Potential Insider Threat

If an employee or an internal user is trying to access the system with a private IP, they might be bypassing security controls.
If external users are accessing from a private IP, it means there’s a security misconfiguration or unauthorized access.
Missing Location Data (City & Country)

All legitimate logins should have a country and city.
Since these fields are empty, it suggests that the system could not determine the true location of this login.

How I Found It?
1. Used SQL to detect logins from private/internal networks:
2. Identified Company2 (EMAIL2) logging in from a private IP (192.168.0.1).
3. Checked network details and found missing location data.

How to Prevent This in the Future?
✅ Block Logins from Private/Internal Networks Unless Authorized

Only internal system administrators should be allowed to log in from private IPs.
If an external user logs in with a private IP, flag and investigate.
✅ Enforce Stronger Network Monitoring

If users are logging in from unexpected private IPs, there could be an unauthorized internal access point.
✅ Review VPN and Remote Access Settings

If VPNs are allowing logins from private IPs, ensure proper logging and monitoring are in place.
✅ Investigate This Specific Login (Company2 - EMAIL2)

Was this an authorized admin login or an unauthorized attempt?
If unauthorized, block the account and investigate further.
🚀 Final Verdict: HIGH RISK! Needs Immediate Investigation!
Yes, this could be an insider attack or a misconfigured access control issue.
Yes, Company2’s login from 192.168.0.1 should be investigated.
Yes, private IP logins should be blocked or monitored strictly.*/