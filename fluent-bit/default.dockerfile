FROM --platform=linux/amd64 fluent/fluent-bit:1.9.8@sha256:137669ee97787c930ec00a8babff46ecc76988d128cc9e7fa581d1b05ef8fb3d

FROM fluent/fluent-bit:1.9.8

COPY --from=amazon/aws-for-fluent-bit:latest /fluent-bit/kinesis.so /fluent-bit/kinesis.so
COPY --from=amazon/aws-for-fluent-bit:latest /fluent-bit/firehose.so /fluent-bit/firehose.so
COPY --from=amazon/aws-for-fluent-bit:latest /fluent-bit/cloudwatch.so /fluent-bit/cloudwatch.so

CMD ["/fluent-bit/bin/fluent-bit", "-e", "/fluent-bit/firehose.so", "-e", "/fluent-bit/cloudwatch.so", "-e", "/fluent-bit/kinesis.so", "-c", "/fluent-bit/etc/fluent-bit.conf"]
