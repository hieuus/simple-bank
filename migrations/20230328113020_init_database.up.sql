start transaction;

CREATE TABLE "account"
(
    "id"         bigserial PRIMARY KEY,
    "owner"      varchar     NOT NULL,
    "balance"    bigint      NOT NULL,
    "currency"   varchar     NOT NULL,
    "created_at" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "entry"
(
    "id"         bigserial PRIMARY KEY,
    "account_id" bigint      NOT NULL,
    "amount"     bigint      NOT NULL,
    "created_at" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "transfer"
(
    "id"              bigserial PRIMARY KEY,
    "from_account_id" bigint      NOT NULL,
    "to_account_id"   bigint      NOT NULL,
    "amount"          bigint      NOT NULL,
    "created_at"      timestamptz NOT NULL DEFAULT (now())
);

ALTER TABLE "entry"
    ADD FOREIGN KEY ("account_id") REFERENCES "account" ("id");

ALTER TABLE "transfer"
    ADD FOREIGN KEY ("from_account_id") REFERENCES "account" ("id");

ALTER TABLE "transfer"
    ADD FOREIGN KEY ("to_account_id") REFERENCES "account" ("id");

CREATE INDEX ON "account" ("owner");

CREATE INDEX ON "entry" ("account_id");

CREATE INDEX ON "transfer" ("from_account_id");

CREATE INDEX ON "transfer" ("to_account_id");

CREATE INDEX ON "transfer" ("from_account_id", "to_account_id");

COMMENT
ON COLUMN "entry"."amount" IS 'can be negative or positive';

COMMENT
ON COLUMN "transfer"."amount" IS 'must be positive';

commit;