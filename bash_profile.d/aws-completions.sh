# setup tab completions for awscli if its available
AWS_COMPLETER=$(command -v aws_completer)

if [ ! -z "$AWS_COMPLETER" ]; then
  complete -C $AWS_COMPLETER aws
fi
