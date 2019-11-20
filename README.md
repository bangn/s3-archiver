# HTTP server to upload file to S3 and delete local file

## Prerequisites

### Ruby

Vesion 2.3+

### Environment variables

Below environment variables need to be set

```
AWS_REGION
AWS_BUCKET_NAME
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
```

## Usage

### Start server

```
bundle exec rackup
```

Then server can be access using `http://localhost:9292`

### Upload file to s3

```
curl https://localhost:9292/upload -d '{"filename": "/absolute/path/to/filename"}'
```

### Delete local file

```
curl https://localhost:9292/delete -d '{"filename": "/absolute/path/to/filename"}'
```
