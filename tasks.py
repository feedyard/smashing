from invoke import task

@task
def enc(ctx, keyfile):
    ctx.run("openssl aes-256-cbc -e -in {} -out env.ci -k $KEY".format(keyfile))

@task
def dec(ctx):
    ctx.run("openssl aes-256-cbc -d -in env.ci -out env -k $KEY")

@task
def build(ctx):
    ctx.run("docker build -t local/smashing:latest .")