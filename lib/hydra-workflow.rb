# Interface for Workflow Implementations
class Hydra::Workflow
  
  # Registers this workflow with an object & sets up the object to function in the Workflow 
  # @return [ActiveFedora::Base] the object
  def register(object) 
  end
  
  # Returns an object's status with respect to this workflow.
  def status(object) 
  end
  
  # Transitions that can currently be applied to the object given its state.
  # @return [Array] an array of Hydra::WorkflowTransition objects
  def valid_transitions(object) 
  end
  
  # Applies the chosen transition to obj
  # @param [ActiveFedora::Base] the object to apply transition to
  # @param [Hydra::WorkflowTransition or Symbol] either the Transition to be applied or a symbol corresponding to the desired Transition within this Workflow
  def apply_transision(object, transition_name)
  end
  
end