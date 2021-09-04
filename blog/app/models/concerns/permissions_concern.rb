module PermissionsConcern
    extend ActiveSupport::Concern
    
    def is_normal_user?
        self.permission_level.to_i >= 1
    end

    def is_editor?
        self.permission_level.to_i >=2
    end

    def is_admin?
        self.permission_level.to_i >= 3
    end
end