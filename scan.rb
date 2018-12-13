require 'xcodeproj'

## Created 13.12.2018 by Serge Rylko.
## File contains functions to manage files and groups in iOS project.
## Functions use xcodeproj library API.
## xcodeproj should be installed (by brew - recommended)

def addfiles(direc, current_group, main_target, changed = false)

  puts "addfiles - `direct`=`#{direc}`, `current_group`=`#{current_group}`, `main_target`=`#{main_target}`"
  Dir.glob(direc) do |item|
    puts "addfiles - `item`=`#{item}`"
      next puts "Next because `.` or `.DS_Store`" if item == '.' or item == '.DS_Store'
      next puts "Next because file (`#{File.basename(item)}`) was in `current_group.children` (#{current_group})" if current_group.children.map { |f| f.name }.include? File.basename(item)
      if File.directory?(item)
          new_folder = File.basename(item)
          created_group = current_group.new_group(new_folder, new_folder)
          changed = addfiles("#{item}/*", created_group, main_target, changed)
      else 
      	newFileName = item.split('/').last
        	i = current_group.new_file(newFileName)
        	main_target.add_file_references([i])
        	changed = true
        
      end
  end
  return changed
end


def add_group_to_project(project_path, name_of_generated_folder)
	project = Xcodeproj::Project.open(project_path)

	generated_group = project.main_group[name_of_generated_folder]
	unless generated_group
  	generated_group = project.main_group.new_group(name_of_generated_folder, name_of_generated_folder)
	end

	main_target = project.targets.first
	added_new_files = addfiles("#{name_of_generated_folder}/*", generated_group, main_target)

	if added_new_files
    project.save
  end
end


def remove_group_reference(project_path, group_to_remove)

	project = Xcodeproj::Project.open(project_path)

 	puts("removing for #{group_to_remove}") 

 	to_remove = project.main_group.recursive_children_groups.find { |group| group.path == group_to_remove }
 	
 	if to_remove.nil?	
 		throw_error("Group -- #{group_to_remove} not found or not specified")
 	end
	
	batch = to_remove.recursive_children
	
	if !batch.empty?
		batch.each { |child| child.remove_from_project}
	end
	
	to_remove.remove_from_project

 	project.save
end


def throw_error(message)
	puts(message.red)
	system('exit 51')
	exit 51
end