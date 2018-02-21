from invoke import task

@task
def enc(ctx, file='local.env', encoded_file='env.ci'):
    ctx.run("openssl aes-256-cbc -e -in {} -out {} -k $KEY".format(file, encoded_file))

@task
def dec(ctx, encoded_file='env.ci', file='local.env'):
    ctx.run("openssl aes-256-cbc -d -in {} -out {} -k $KEY".format(encoded_file, file))

@task
def build(ctx):
    ctx.run("docker build -t local/smashing:latest .")