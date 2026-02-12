FROM --platform=linux/amd64 fluent/fluent-bit:1.9.10@sha256:b33d4bf7f7b870777c1f596bc33d6d347167d460bc8cc6aa50fddcbedf7bede5

FROM fluent/fluent-bit:1.9.10

COPY --from=amazon/aws-for-fluent-bit:latest /fluent-bit/kinesis.so /fluent-bit/kinesis.so
COPY --from=amazon/aws-for-fluent-bit:latest /fluent-bit/firehose.so /fluent-bit/firehose.so
COPY --from=amazon/aws-for-fluent-bit:latest /fluent-bit/cloudwatch.so /fluent-bit/cloudwatch.so

CMD ["/fluent-bit/bin/fluent-bit", "-e", "/fluent-bit/firehose.so", "-e", "/fluent-bit/cloudwatch.so", "-e", "/fluent-bit/kinesis.so", "-c", "/fluent-bit/etc/fluent-bit.conf"]
