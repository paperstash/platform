module PaperStash
  def self.config
    RecursiveOpenStruct.new({
      app: {
        host: ENV['HOST'],
        port: ENV['PORT'].to_i,
        workers: ENV['PUMA_WORKERS'].to_i,
        threads: {
          min: ENV['PUMA_MAX_THREADS'].to_i,
          max: ENV['PUMA_MIN_THREADS'].to_i
        },
        sessions: {
          domain: ".#{ENV['HOST']}",
          lifetime: 31_536_000,
          secret: ENV['PAPERSTASH_SESSION_SECRET']
        }
      },
      worker: {
        threads: ENV['SIDEKIQ_THREADS'].to_i
      },
      mailer: {
        smtp: {
          host: ENV['PAPERSTASH_SMTP_HOST'],
          port: ENV['PAPERSTASH_SMTP_PORT'].to_i,
          user: ENV['PAPERSTASH_SMTP_USER'],
          password: ENV['PAPERSTASH_SMTP_PASSWORD']
        }
      },
      database: {
        url: ENV['PAPERSTASH_DATABASE_URL'],
        pool: {
          size: ENV['PAPERSTASH_DATABASE_CONNECTIONS'].to_i
        }
      },
      redis: {
        url: ENV['PAPERSTASH_REDIS_URL']
      },
      elastic_search: {
        url: ENV['PAPERSTASH_ELASTIC_SEARCH_URL']
      },
      storage: {
        host: ENV['S3_HOST'],
        bucket: ENV['S3_BUCKET'],
        access_key: ENV['S3_ACCESS_KEY'],
        secret_access_key: ENV['S3_SECRET_ACCESS_KEY']
      },
      sentry: {
        dsn: ENV['SENTRY_DSN']
      }
    })
  end
end

