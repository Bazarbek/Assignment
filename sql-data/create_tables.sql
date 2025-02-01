CREATE TABLE accounts_activity (
    device_id TEXT,
    start_time TIMESTAMP,
    identity TEXT,
    ips TEXT,
    providers TEXT,
    network TEXT,
    city TEXT,
    country TEXT,
    email TEXT
);
CREATE TABLE transactions (
    id UUID PRIMARY KEY,
    provider TEXT,
    accountid UUID,
    companyid TEXT,
    amount NUMERIC(15, 2),
    created TIMESTAMP,
    status TEXT,
    direction TEXT,
    paymenttype TEXT,
    correlationid UUID,
    participantiban TEXT,
    timezoneoffset NUMERIC(5, 2),
    bic TEXT,
    firsttransfer BOOLEAN,
    mcc TEXT
);