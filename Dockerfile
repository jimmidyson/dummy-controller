# syntax=docker/dockerfile:1.4

# Copyright 2023 Jimmi Dyson.
# SPDX-License-Identifier: Apache-2.0

# hadolint ignore=DL3029
FROM --platform=linux/amd64 gcr.io/distroless/static@sha256:1b4dbd7d38a0fd4bbaf5216a21a615d07b56747a96d3c650689cbb7fdc412b49 as linux-amd64
# hadolint ignore=DL3029
FROM --platform=linux/arm64 gcr.io/distroless/static@sha256:05810557ec4b4bf01f4df548c06cc915bb29d81cb339495fe1ad2e668434bf8e as linux-arm64

# hadolint ignore=DL3006,DL3029
FROM --platform=linux/${TARGETARCH} linux-${TARGETARCH}

COPY dummy-controller /usr/local/bin/dummy-controller

# Use uid of nonroot user (65532) because kubernetes expects numeric user when applying pod security policies
USER 65532
ENTRYPOINT ["/usr/local/bin/dummy-controller"]
