
module FactoryHelpers

  def find_or_create_root_section
    root = Cms::Section.root.first
    unless root
      # This constructor matches how seed data is set up.
      root = Factory(:root_section)
    end
    root
  end

  def root_section
    find_or_create_root_section
  end

  def given_there_is_a_sitemap
    root = find_or_create_root_section
    root.allow_groups = :all
  end

  def given_there_is_a_guest_group
    group_type = Cms::GroupType.guest.first
    unless group_type
      group_type = Cms::GroupType.create!(:name => "Guest", :guest => true)
    end

    guest_group = Cms::Group.guest
    unless guest_group
      guest_group = Cms::Group.create!(:name => 'Guest', :code => Cms::Group::GUEST_CODE, :group_type => group_type)
    end
    guest_group
  end
  alias :given_a_guest_group_exists :given_there_is_a_guest_group

  # Creates a sample uploaded JPG file with binary data.
  def mock_file(options = {})
    file_upload_object({:original_filename => "foo.jpg", :content_type => "image/jpeg"}.merge(options))
  end

  # Creates a TempFile attached to an uploaded file. Used to test attachments
  def file_upload_object(options)
    Cms::MockFile.new_file(options[:original_filename], options[:content_type])
  end

  def given_there_is_a_content_type(model_class)
    Factory(:content_type, :name => model_class.to_s)
  end

  def create_admin_user(attrs={})
    Factory(:cms_admin, {:login => "cmsadmin"}.merge(attrs))
  end

  def given_there_is_a_cmsadmin
    create_admin_user
  end
end