require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "HydraWorkflow" do
  
  before(:all) do
    class TestReleaseWorkflow
      
      workflow_datastream_name "release_workflow"
      
      has_transition :release do
        
        has_requirement :provide_title do
          test do
            title_values = target.datastreams["descMetadata"].term_values(:title_info, :main_title)
            !title_values.first.empty?
          end
          failure_message "Please provide a title."
        end
        
        has_requirement :provide_author do
          test do
            author_entries = datastreams["descMetadata"].find_by_terms_and_value('//oxns:name[@type="personal" and contains(oxns:role, "Author") and string-length(oxns:namePart[@type="family"]) > 0 ]')    
            !author_entries.empty?
          end
          failure_message "Please provide an author (first name and last name)."
        end
        
        has_requirement :attach_file do
          test do
            !target.parts(:response_format=>:id_array).empty?
          end
          failure_message "Please attach at least one file."
        end
        
        triggers do
          # set released_values = "released"
          # ... blah ...
        end
        
      end
    end
  end
  
  it "should allow you to test an object" do
    obj = ActiveFedora::Base.new
    TestReleaseWorkflow.register(obj)
    
    obj.workflows.get_state(:release).should == :not_released
    
    release_transition = TestReleaseWorkflow.transitions.find(:release)
    release_transition.should be_kind_of(Hydra::WorkflowTransition)
    
    reqs = release_transition.requirements
    [:provide_title, :provide_author, :attach_file].each do |requirement_name|
      reqs[requirement_name].satisfied?(obj).should == false
    end
    reqs[:provide_title].status(obj).should == "Please provide a title."
    reqs[:provide_author].status(obj).should == "Please provide an author (first name and last name)."
    reqs[:attach_file].status(obj).should == "Please attach at least one file."
    
  end
  
  it "fails" do
    fail "hey buddy, you should probably rename this file and start specing for real"
  end
end
