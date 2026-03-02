# importer-template

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square)

Template helm chart for the creation of IMPORTERS

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| John Funk | <john.funk@mobidrom.nrw> |  |

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| oci://ghcr.io/mobidrom/mobidp-devops | mobidp-base-importer-chart | 0.3.4 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| mobidp-base-importer-chart.importer.enabled | bool | `true` |  |
| mobidp-base-importer-chart.importer.metadata | object | `{"destination":"","frequency":"","source":""}` | REQUIRED; Human-readable importer description |
| mobidp-base-importer-chart.importer.metadata.destination | string | `""` | REQUIRED; Specify data target, eg KStore |
| mobidp-base-importer-chart.importer.metadata.frequency | string | `""` | REQUIRED; Specify human-readable schedule format |
| mobidp-base-importer-chart.importer.metadata.source | string | `""` | REQUIRED; Specify data source |
| mobidp-base-importer-chart.importer.name | string | `""` | REQUIRED; Importer name |
| mobidp-base-importer-chart.importer.schedule | string | `""` | REQUIRED; Specify how often the importer should run using cron syntax |
| mobidp-base-importer-chart.importer.steps | object | `{"extract":[{"config":[{"name":"","value":""}],"name":"","secret":[{"name":"","value":""}],"secretFile":[{"name":"","value":""}]}],"load":[{"config":[{"name":"","value":""}],"name":"","secret":[{"name":"","value":""}],"secretFile":[{"name":"","value":""}]},[{"config":[{"name":"","value":""}],"name":""},{"config":[{"name":"","value":""}],"name":""}],{"config":[{"name":"","value":""}],"name":""}],"transform":[{"config":[{"name":"","value":""}],"name":"","secret":[{"name":"","value":""}],"secretFile":[{"name":"","value":""}]},[{"config":[{"name":"","value":""}],"name":""},{"config":[{"name":"","value":""}],"name":""}],{"config":[{"name":"","value":""}],"name":""}]}` | REQUIRED; Define the ETL steps to run for the specific importer. |
| mobidp-base-importer-chart.importer.steps.extract | list | `[{"config":[{"name":"","value":""}],"name":"","secret":[{"name":"","value":""}],"secretFile":[{"name":"","value":""}]}]` | Within the 'extract' section, all steps run in parallel. |
| mobidp-base-importer-chart.importer.steps.extract[0] | object | `{"config":[{"name":"","value":""}],"name":"","secret":[{"name":"","value":""}],"secretFile":[{"name":"","value":""}]}` | REQUIRED; Name of the extractor (should equal <extractor-name> in `kubernetes/kubectl/extractor/<extractor-name>`) |
| mobidp-base-importer-chart.importer.steps.extract[0].config | list | `[{"name":"","value":""}]` | REQUIRED; Provide configuration like the URL to extract data from |
| mobidp-base-importer-chart.importer.steps.extract[0].config[0] | object | `{"name":"","value":""}` | REQUIRED; Name of the environment variable |
| mobidp-base-importer-chart.importer.steps.extract[0].config[0].value | string | `""` | REQUIRED; Value of the environment variable |
| mobidp-base-importer-chart.importer.steps.extract[0].secrets | list | `[{"name":"","secretKeyRef":""}]` | NOTE: 'secretKeyRef' MUST point to a secret stored in Bitwarden Secrets Manager (see 'kubernetes/kubectl/mobidp-data-import/README.md')! |
| mobidp-base-importer-chart.importer.steps.extract[0].secretFile | list | `[{"name":"","secretKeyRef":""}]` | NOTE: 'secretKeyRef' MUST point to a secret stored in Bitwarden Secrets Manager (see 'kubernetes/kubectl/mobidp-data-import/README.md')! |
| mobidp-base-importer-chart.importer.steps.extract[0].secretFile[0] | object | `{"name":"","value":""}` | REQUIRED; Name of the file. MUST match the name defined in the mountPath of the extractor! |
| mobidp-base-importer-chart.importer.steps.extract[0].secretFile[0].value | string | `""` | REQUIRED; BASE64 encoded encrypted value of the file content. Will be decrypted by the cluster |
| mobidp-base-importer-chart.importer.steps.extract[0].secret[0] | object | `{"name":"","value":""}` | REQUIRED; Name of the environment variable |
| mobidp-base-importer-chart.importer.steps.extract[0].secret[0].value | string | `""` | REQUIRED; BASE64 encoded encrypted value of the environment variable. Will be decrypted by the cluster |
| mobidp-base-importer-chart.importer.steps.load | list | `[{"config":[{"name":"","value":""}],"name":"","secret":[{"name":"","value":""}],"secretFile":[{"name":"","value":""}]},[{"config":[{"name":"","value":""}],"name":""},{"config":[{"name":"","value":""}],"name":""}],{"config":[{"name":"","value":""}],"name":""}]` | The workflow proceeds to the next outer list item only after all steps in the current inner list complete. |
| mobidp-base-importer-chart.importer.steps.load[0] | object | `{"config":[{"name":"","value":""}],"name":"","secret":[{"name":"","value":""}],"secretFile":[{"name":"","value":""}]}` | REQUIRED; Name of the loader (should equal <loader-name> in `kubernetes/kubectl/loader/<loader-name>`) |
| mobidp-base-importer-chart.importer.steps.load[0].config | list | `[{"name":"","value":""}]` | REQUIRED; Provide configuration like the filename that needs to be fetched from S3 |
| mobidp-base-importer-chart.importer.steps.load[0].config[0] | object | `{"name":"","value":""}` | REQUIRED; Name of the environment variable |
| mobidp-base-importer-chart.importer.steps.load[0].config[0].value | string | `""` | REQUIRED; Value of the environment variable |
| mobidp-base-importer-chart.importer.steps.load[0].secrets | list | `[{"name":"","secretKeyRef":""}]` | NOTE: 'secretKeyRef' MUST point to a secret stored in Bitwarden Secrets Manager (see 'kubernetes/kubectl/mobidp-data-import/README.md')! |
| mobidp-base-importer-chart.importer.steps.load[0].secretFile | list | `[{"name":"","secretKeyRef":""}]` | NOTE: 'secretKeyRef' MUST point to a secret stored in Bitwarden Secrets Manager (see 'kubernetes/kubectl/mobidp-data-import/README.md')! |
| mobidp-base-importer-chart.importer.steps.load[0].secretFile[0] | object | `{"name":"","value":""}` | REQUIRED; Name of the file. MUST match the name defined in the mountPath of the loader! |
| mobidp-base-importer-chart.importer.steps.load[0].secretFile[0].value | string | `""` | REQUIRED; BASE64 encoded encrypted value of the file content. Will be decrypted by the cluster |
| mobidp-base-importer-chart.importer.steps.load[0].secret[0] | object | `{"name":"","value":""}` | REQUIRED; Name of the environment variable |
| mobidp-base-importer-chart.importer.steps.load[0].secret[0].value | string | `""` | REQUIRED; BASE64 encoded encrypted value of the environment variable. Will be decrypted by the cluster |
| mobidp-base-importer-chart.importer.steps.transform | list | `[{"config":[{"name":"","value":""}],"name":"","secret":[{"name":"","value":""}],"secretFile":[{"name":"","value":""}]},[{"config":[{"name":"","value":""}],"name":""},{"config":[{"name":"","value":""}],"name":""}],{"config":[{"name":"","value":""}],"name":""}]` | The workflow proceeds to the next outer list item only after all steps in the current inner list complete. |
| mobidp-base-importer-chart.importer.steps.transform[0] | object | `{"config":[{"name":"","value":""}],"name":"","secret":[{"name":"","value":""}],"secretFile":[{"name":"","value":""}]}` | REQUIRED; Name of the transformer (should equal <transformer-name> in `kubernetes/kubectl/transformer/<transformer-name>`) |
| mobidp-base-importer-chart.importer.steps.transform[0].config | list | `[{"name":"","value":""}]` | REQUIRED; Provide list of configuration like the filename that needs to be fetched from the Object Store |
| mobidp-base-importer-chart.importer.steps.transform[0].config[0] | object | `{"name":"","value":""}` | REQUIRED; Name of the environment variable |
| mobidp-base-importer-chart.importer.steps.transform[0].config[0].value | string | `""` | REQUIRED; Value of the environment variable |
| mobidp-base-importer-chart.importer.steps.transform[0].secrets | list | `[{"name":"","secretKeyRef":""}]` | NOTE: 'secretKeyRef' MUST point to a secret stored in Bitwarden Secrets Manager (see 'kubernetes/kubectl/mobidp-data-import/README.md')! |
| mobidp-base-importer-chart.importer.steps.transform[0].secretFile | list | `[{"name":"","secretKeyRef":""}]` | NOTE: 'secretKeyRef' MUST point to a secret stored in Bitwarden Secrets Manager (see 'kubernetes/kubectl/mobidp-data-import/README.md')! |
| mobidp-base-importer-chart.importer.steps.transform[0].secretFile[0] | object | `{"name":"","value":""}` | REQUIRED; Name of the file. MUST match the name defined in the mountPath of the transformer! |
| mobidp-base-importer-chart.importer.steps.transform[0].secretFile[0].value | string | `""` | REQUIRED; BASE64 encoded encrypted value of the file content. Will be decrypted by the cluster |
| mobidp-base-importer-chart.importer.steps.transform[0].secret[0] | object | `{"name":"","value":""}` | REQUIRED; Name of the environment variable |
| mobidp-base-importer-chart.importer.steps.transform[0].secret[0].value | string | `""` | REQUIRED; BASE64 encoded encrypted value of the environment variable. Will be decrypted by the cluster |
| mobidp-base-importer-chart.importer.steps.transform[1] | list | `[{"config":[{"name":"","value":""}],"name":""},{"config":[{"name":"","value":""}],"name":""}]` | Optional; Provide additional transform steps that run parallely |
| mobidp-base-importer-chart.importer.steps.transform[2] | object | `{"config":[{"name":"","value":""}],"name":""}` | Optional; Provide additional transform steps that run sequentially |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
