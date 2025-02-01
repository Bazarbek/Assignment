COPY accounts_activity(device_id, start_time, identity, ips, providers, network, city, country, email)
FROM '/Users/bazarbek/Downloads/Assignment/csv_files/accounts_activity.csv'
DELIMITER ';'
CSV HEADER;

COPY transactions(id, provider, accountid, companyid, amount, created, status, direction, paymenttype, correlationid, participantiban, timezoneoffset, bic, firsttransfer, mcc)
FROM '/Users/bazarbek/Downloads/Assignment/csv_files/transactions.csv'
WITH (
    FORMAT CSV,
    DELIMITER ',',
    HEADER,
    QUOTE '"',
    NULL ''
);










