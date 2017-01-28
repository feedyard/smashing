def base_version
  File.readlines('./VERSION').first.strip
end

def container_name
  File.basename(Dir.getwd)
end

# simple published version calculator
# nods to Mike Heijmans for this function
def current_version
  # fetch the list of previous tags push to the REGISTRY
  taginfo = JSON.parse(HTTParty.get("#{REGISTRY}/#{LIBRARY}/#{container_name}/tags/").body)['results']

  # return just the base if tags are nil or the VERSION is new
  return {base: base_version, build: nil} if taginfo.nil?

  # create array of tags
  tags = []
  taginfo.each do |tag|
    tags << tag['name']
  end
  current_base = tags.grep(/#{base_version}/)

  # return just the base if there are no previous tags at this version, e.g., this is a base version update
  return {base: base_version, build: nil} if current_base.empty?

  # otherwise sort and return latest version
  build = current_base.sort { |x,y|
    a = x.split('.')[base_version.split('.').count].to_i
    b = y.split('.')[base_version.split('.').count].to_i
    a <=> b
  }.last.split('.').last.to_i
  {base: base_version, build: build}
end



def next_version
  "#{base_version}.#{(current_version[:build] || -1) + 1}"
end