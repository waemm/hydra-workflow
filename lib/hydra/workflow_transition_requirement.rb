class Hydra::WorkflowTransitionRequirement
  
  # Returns lexical (string) representation of the object's status with respect to this TransitionRequirement
  def status(object)
  end
  
  # Returns a boolean representation of whether the object has satisfied the TransitionRequirement
  def satisfied?(object)
  end
  
end

# Raised if a given transition is not applicable to an object. Error message should list the current valid transitions for the object. 
class TransitionNotApplicable < StandardError
end