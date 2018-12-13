
#!/bin/sh

## Shell Script Example

PROJECT_PATH="myProject.xcodeproj"
GROUP_TO_ADD_1="Group1"
GROUP_TO_ADD_2="Group2"
GROUP_TO_REMOVE_1="Group3"

set -e

# add First group reference to project
ruby -r "./Scripts/scan.rb" -e "add_group_to_project '$PROJECT_PATH', '$GROUP_TO_ADD_1'"

# add Classes group reference
ruby -r "./Scripts/scan.rb" -e "add_group_to_project '$PROJECT_PATH', '$GROUP_TO_ADD_2'"

# remove Third group reference
ruby -r "./Scripts/scan.rb" -e "remove_group_reference '$PROJECT_PATH', '$GROUP_TO_REMOVE_1'"

echo "readdProjectFiles completed"







