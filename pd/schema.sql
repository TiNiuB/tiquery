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