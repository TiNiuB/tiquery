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

CREATE TABLE IF NOT EXISTS `pd_kernel_info` (
        `version`               VARCHAR(255),
        `arguments`             VARCHAR(255),
        `path`                  VARCHAR(255),
        `device`                VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS `pd_memory_info` (
        `memory_total`          BIGINT,
        `memory_free`           BIGINT,
        `buffers`               BIGINT,
        `cached`                BIGINT,
        `swap_cached`           BIGINT,
        `active`                BIGINT,
        `inactive`              BIGINT,
        `swap_total`            BIGINT,
        `swap_free`             BIGINT
);

CREATE TABLE IF NOT EXISTS `pd_system_info` (
        `hostname`              VARCHAR(255),
        `uuid`                  VARCHAR(255),
        `cpu_type`              VARCHAR(255),
        `cpu_subtype`           VARCHAR(255),
        `cpu_brand`             VARCHAR(255),
        `cpu_physical_cores`    INT,
        `cpu_logical_cores`     INT,
        `cpu_microcode`         VARCHAR(255),
        `physical_memory`       BIGINT,
        `hardware_vendor`       VARCHAR(255),
        `hardware_model`        VARCHAR(255),
        `hardware_version`      VARCHAR(255),
        `hardware_serial`       VARCHAR(255),
        `computer_name`         VARCHAR(255),
        `local_hostname`        VARCHAR(255)
);