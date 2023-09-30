# Driver

AWS has this arbitrary rule whereby RDS clusters/instances can be stopped temporarily, but they will magically turn themselves back on after 7 days.

The small solution in this repo polls the status of a specified RDS cluster/instance (works for the Aurora flavour too) with a controllable frequency, and if the cluster/instance is not stopped, it goes ahead and stops it.

# Usage

Open the `stop-db-cluster/params.json` or `stop-db-instance/params.json` file (depending on whether you want to keep an entire cluster stopped or a single instance) and edit with your own values. See the `Parameters` section of `stop-db-cluster/main.yml` or `stop-db-instance/main.yml` if you need a better understanding of what each parameter does.

Then simply hop on your command line, navigate to the folder root and run `./deploy.sh`.

When prompted, enter inputs for AWS profile, stack name and whether you're targetting a cluster or single instance. Wait for the script to finish and give you a congratulatory message. Now sit back and relax at the satisfaction that your RDS cluster will be (almost) continuously stopped.
