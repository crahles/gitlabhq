# Controller for viewing a repository's file structure
class Projects::FindController < Projects::BaseTreeController
  def show
    @blobs = []
    Struct.new("Blob", :root, :name)

    @repo.lookup(@commit.id).tree.walk_blobs do |root, entry|
      @blobs << Struct::Blob.new(root, entry[:name])
    end

    return not_found! if @blobs.empty?

    respond_to do |format|
      format.html
      # Disable cache so browser history works
      format.js { no_cache_headers }
    end
  end

end
