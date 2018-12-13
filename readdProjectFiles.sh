
#!/bin/sh


PROJECT_PATH="unity_bridge.xcodeproj"
LIBRARIES_GROUP="Libraries"
CLASSES_GROUP="Classes"
LIBIL2CPP_GROUP="libil2cpp"

set -e

# remove Libraries group reference
ruby -r "./Scripts/scan.rb" -e "remove_group_reference '$PROJECT_PATH', '$LIBRARIES_GROUP'"

# remove Classes group reference
ruby -r "./Scripts/scan.rb" -e "remove_group_reference '$PROJECT_PATH', '$CLASSES_GROUP'"

# add Libraries group reference
ruby -r "./Scripts/scan.rb" -e "add_group_to_project '$PROJECT_PATH', '$LIBRARIES_GROUP'"

# add Classes group reference
ruby -r "./Scripts/scan.rb" -e "add_group_to_project '$PROJECT_PATH', '$CLASSES_GROUP'"

# remove libil2cpp group reference
ruby -r "./Scripts/scan.rb" -e "remove_group_reference '$PROJECT_PATH', '$LIBIL2CPP_GROUP'"

echo "readdProjectFiles completed"







