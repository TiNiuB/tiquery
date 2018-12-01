CREATE TABLE IF NOT EXISTS `pd_store` (
        `id`                    BIGINT,
        `address`               VARCHAR(255),
        `state`                 VARCHAR(255),
        `version`               VARCHAR(255),
        `capacity`              BIGINT,
        `available`             BIGINT,
        `leader_count`          BIGINT,
        `region_count`          BIGINT,
        `is_busy`               INT,
        `start_ts`              VARCHAR(255),
        `last_heartbeat_ts`     VARCHAR(255),
        `uptime`                VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS `pd_store_label` (
        `id`                    BIGINT,
        `label_key`             VARCHAR(255),
        `label_value`           VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS `pd_region` (
        `id`                    BIGINT,
        `start_key`             VARCHAR(1024),
        `end_key`               VARCHAR(1024),
        `conf_ver`              BIGINT,
        `version`               BIGINT,
        `leader_peer_id`        BIGINT,
        `leader_store_id`       BIGINT,
        `written_bytes`         BIGINT,
        `read_bytes`            BIGINT,
        `approximate_size`      BIGINT,
        `approximate_keys`      BIGINT
);

CREATE TABLE IF NOT EXISTS `pd_region_peer` (
        `id`                    BIGINT,
        `region_id`             BIGINT,
        `store_id`              BIGINT,
        `is_leader`             INT,
        `is_down`               INT,
        `is_pending`            INT
);

CREATE TABLE IF NOT EXISTS `pd_config` (
        `module`                VARCHAR(255),
        `key`                   VARCHAR(255),
        `value`                 VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS `service` (
        `instance`              VARCHAR(255),
        `type`                  VARCHAR(255),
        `name`                  VARCHAR(255),
        `port`                  INT,
        `log_file`              VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS `memory` (
       `instance`              VARCHAR(255),
       `pid` BIGINT,
        `rss`   BIGINT,
        `vms`    BIGINT,
        `data`   BIGINT,
        `stack`  BIGINT,
        `locked` BIGINT,
        `swap`  BIGINT
);

CREATE TABLE IF NOT EXISTS `cpu` (
       `instance`              VARCHAR(255),
       `pid` BIGINT,
        `cpu`       TEXT,
        `user`      DOUBLE,
        `system`    DOUBLE,
        `idle`      DOUBLE,
        `nice`      DOUBLE,
        `iowait`    DOUBLE,
        `irq`       DOUBLE,
        `softirq`   DOUBLE,
        `steal`     DOUBLE,
        `guest`     DOUBLE,
        `guestNice` DOUBLE,
        `stolen`    DOUBLE
);
