#!/bin/bash

WORKFLOW_NAME="$1"
STEP_CONCLUSION="$2"
REPOSITORY="$3"
RUN_ID="$4"
SLACK_WEBHOOK="$5"

echo "Sending Slack notification for failed steps."

COLOR="#FF0000"
ATTACHMENT=$(cat <<EOF
{
  "attachments": [
    {
      "color": "${COLOR}",
      "title": "SecureSDLC GitHub Workflow ${WORKFLOW_NAME} state: ${STEP_CONCLUSION}",
      "title_link": "https://github.com/${REPOSITORY}",
      "fields": [
        {
          "value": "GitHub Workflow: https://github.com/${REPOSITORY}/actions/runs/${RUN_ID}"
        }
      ],
      "footer": "Dashboard: https://grafana.ops.kraken.zone/dashboards/f/tf-appsec/devsecops"
    }
  ]
}
EOF
)

curl -s -X POST -H "Content-type: application/json" --data "$ATTACHMENT" "$SLACK_WEBHOOK"
