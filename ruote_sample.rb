# This process is triggered when you submit a 'release' request

# Solution 1 -- allows Ruote to handle representing the flow of business logic while encapsulating
# all of the actual business logic in SampleReleaseWorkflow
# * how can this be made more generic -- so you can switch out alternative requirements & release logic
pdef = Ruote.process_definition, :name=>"release" do
  sequence do
    check_requirements
    release
  end
end

engine.register_participant 'check_requirements'do
  SampleReleaseWorkflow.check_requirements(workitem.fields['doc_id'])
end
engine.register_participant 'release' do |workitem|
  SampleReleaseWorkflow.release(workitem.fields['doc_id'])
end

# ----------   OR  ----------


# Solution 2 -- this seems like it would lead to duplication of code -- ie listing requirements in two places instead of one.
pdef = Ruote.process_definition, :name=>"release" do
  sequence do
    concurrence do
      requirements_checker :requirement=>provide_title
      requirements_checker :requirement=>provide_author
      requirements_checker :requirement=>attach_file
    end
    release
  end
end

engine.register_participant 'requirements_checker' do
  SampleReleaseWorkflow.check_requirement(workitem.fields['requirement'])
end
engine.register_participant 'release' do |workitem|
  SampleReleaseWorkflow.release(workitem.fields['doc_id'])
end



