class Hydra::ObjectWorkflowManager
  
  # The object thst this WorkflowManager is managing workflows for
  attr_accessor :target_object
  
  # Lists all of the workflows registered for the target_object 
  # @return [Array] an array of Workflows
  def list 
  end
  
  # @return [String] the target_object's current state for the Workflow identified by workflow_id. 
  # @raise [WorkflowNotApplicable] if it isn't registered with the object
  # @raise  [WorkflowNotDefined] if no workflow by that name exists.  
  def get_state(workflow_id) 
  end
  
  # Test whether a workflow corresponding to workflow_id is associated with the target_object
  # @return [Boolean]
  def include?(workflow_id)
  end
  
  # Returns the HydraWorkflow corresponding to workflow_id if it is associated with the target_object
  def find(workflow_id)
  end
end

# Raised if an object is not registered with a given workflow 
class WorkflowNotApplicable < StandardError
end

class WorkflowNotDefined < StandardError
end