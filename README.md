# hwx-sdlc-apps
Hortonworks SDLC and Applications

# SDLC

This section contains scripts and support files to run various Big Data Scenarios.
## Running TPCDS

[baseline/hive/hive-tpcds.yaml](baseline/hive/hive-tpcds.yaml) is an Ansible playbook for running TPCDS.

Pre-requisites:
1. Create the user to run this as on the cluster.
  - Playbook: [Onboarding User](standards/02_onboard_user.yaml)
2. Configure Hive Container Sizes for at least 4Gb.
3. Install and Configure Ranger
  - Set Ranger parameters (url/user/password) in host.yaml for cluster.
4. Run Playbook: [HDP Best Practice Ranger Rules](standards//01_bp_ranger_policies.yaml)
5. Configure Hive for 'nonstrict' partition mode.
  - `hive.exec.dynamic.partition.mode=nonstrict`

## ACID

The [apps/cdc](apps/cdc) there are playbooks used to create a dataset and populate with generated data through a few different approaches.  Append, ACID insert and Merge.  The intent is to also show how the Hive Metastore Compactor works.

### Parameters

- gen_mappers (default 4) - How many mappers are used to generate a dataset.
- gen_count: (default 1000000) - How many records are created with each data generation cycle.
- acid_iterations: (default 20) - How many loops to run for each acid effort.
- set: (default 1) - Controls which scenario we're running.  Each of the support files has a postfix to the filename (IE: _1).  This represents the scenario.  Set this value to change which scenario to run.
- part: (default 10) - Identifies the partition to write when a partition is a part of the scenario.

These values can be overridden at run time when the playbook is launched by specifying '-e key=value' when running the playbook.

### Scenario #1
Simple ACID test that will build out a set of tables:
- raw
- append
- acid
- merge

These 'raw' table is populated by the generator script which uses the `acid_gen_1.yaml` control file to generate a dataset.

SQL scripts are called to create and load the data from the 'external' table into these various target tables with various techniques.

The goal here is to show how a managed table via 'acid' can be much more efficient and 'managed' with regard to files than an append non-acid table.
