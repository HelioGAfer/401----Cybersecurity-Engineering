# Cyberians-MidTerm-Project Code For All 401

## Project Objectives:

For this project, Chewy has requested a demonstration of how you'll be able to protect PII and PCI data in the cloud from being exfiltrated. You'll need to implement the following in AWS Cloud to demonstrate to Chewy how you'll prevent their PII and PCI data from falling into the wrong hands:

Proper IAM for all team members must be implemented using AWS best practices
- Use root sparingly and with MFA
- Administrator permissions OK

CIS-compliant Data Server
- Chewy maintains a Linux server instance containing PII and PCI data
- PII and PCI data needs to be encrypted at rest and in transit

SIEM/log aggregation system
- Options include Splunk Enterprise (Trial), CloudWatch, and Elastic Stack
- Configure to ingest event logs in real time from key assets
- Demonstrate an attack TTP with a goal of PII/PCI data exfiltration. The attack should trigger an event that gets ingested by the SIEM and raises an alert of some kind that notifies an administrator via SMS or SMTP

Cloud Monitoring
- Capture traffic for the client to demonstrate how a data exfiltration attempt will be detected in the AWS Cloud using VPC Flow Logs and any additional automation necessary
- An AWS Lambda function triggering a relevant response to a detected threat (this fulfills the requirement for a shell script)

DLP controls
- Implement a DLP solution of your choosing on a transport protocol of your choosing
- Configured to detect and prevent the exfiltration of PII and PCI data classes from an instance or instances

Novelty
- Challenge yourselves to implement a novel tool, system, or technique that was not demonstrated or performed during lab time in term 1 of your Ops 401 class

