# To use: add a .jira-url file in the base of your project
#         You can also set JIRA_URL in your .zshrc or put .jira-url in your home directory
#         .jira-url in the current directory takes precedence. The same goes with .jira-prefix
#         and JIRA_PREFIX.
#
# If you use Rapid Board, set:
#JIRA_RAPID_BOARD="true"
# in you .zshrc
#
# Setup: cd to/my/project
#        echo "https://name.jira.com" >> .jira-url
# Usage: jira           # opens a new issue
#        jira ABC-123   # Opens an existing issue
open_jira_issue () {
  local open_cmd
  if [[ "$OSTYPE" = darwin* ]]; then
    open_cmd='open'
  else
    open_cmd='xdg-open'
  fi

  local jira_url
  if [ -f .jira-url ]; then
    jira_url=$(cat .jira-url)
  elif [ -f ~/.jira-url ]; then
    jira_url=$(cat ~/.jira-url)
  elif [[ "${JIRA_URL}" != "" ]]; then
    jira_url=${JIRA_URL}
  else
    echo "JIRA url is not specified anywhere."
    return 1
  fi

  local jira_prefix
  if [ -f .jira-prefix ]; then
    jira_prefix=$(cat .jira-prefix)
  elif [ -f ~/.jira-prefix ]; then
    jira_prefix=$(cat ~/.jira-prefix)
  elif [[ "${JIRA_PREFIX}" != "" ]]; then
    jira_prefix=${JIRA_PREFIX}
  else
    jira_prefix=""
  fi

  if [ -z "$1" ]; then
    echo "Opening new issue"
    open_command "${jira_url}/secure/CreateIssue!default.jspa"
  elif [[ "$1" = "assigned" || "$1" = "reported" ]]; then
    jira_query $@
  else
    local addcomment=''
    if [[ "$2" == "m" ]]; then
      addcomment="#add-comment"
      echo "Add comment to issue #$1"
    else
      echo "Opening issue #$1"
    fi

    if [[ "$JIRA_RAPID_BOARD" == "true" ]]; then
      $open_cmd "${jira_url}/issues/${jira_prefix}${1}${addcomment}"
    else
      $open_cmd "${jira_url}/browse/${jira_prefix}${1}${addcomment}"
    fi
  fi
}

jira_name () {
  if [[ -z "$1" ]]; then
    if [[ "${JIRA_NAME}" != "" ]]; then
      jira_name=${JIRA_NAME}
    else
      echo "JIRA_NAME not specified"
      return 1
    fi
  else
    jira_name=$@
  fi
}

jira_query () {
  local jira_name
  local verb
  verb="$1"
  local lookup
  local preposition
  if [[ "${verb}" = "reported" ]]; then
    lookup=reporter
    preposition=by
  elif [[ "${verb}" = "assigned" ]]; then
    lookup=assignee
    preposition=to
  else
    echo "not a valid lookup $verb"
    return 1
  fi
  shift 1
  jira_name $@
  if [[ $? = 1 ]]; then
    return 1
  fi
  echo "Browsing issues ${verb} ${preposition} ${jira_name}"
  $open_cmd "${jira_url}/secure/IssueNavigator.jspa?reset=true&jqlQuery=${lookup}+%3D+%22${jira_name}%22+AND+resolution+%3D+unresolved+ORDER+BY+priority+DESC%2C+created+ASC"
}

alias jira='open_jira_issue'

