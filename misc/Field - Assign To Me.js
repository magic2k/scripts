<script type="text/javascript">
(function($) {
 
    function addAssignToMe(id){
        if (AJS.$('#assign-to-me-'+id).length == 0){
            AJS.$("#"+id).next().after("<a id='assign-to-me-" + id + "' href='#'>Assign to me</a>");

            AJS.$("#assign-to-me-"+id).click(function() {
               AJS.$("#"+id).val(JIRA.Meta.getLoggedInUser().name);
            });
        }
    }
  
    AJS.toInit(function(){  
        addAssignToMe("customfield_10010");
    })
  
    JIRA.bind(JIRA.Events.NEW_CONTENT_ADDED, function (e, context) {
        addAssignToMe("customfield_10010");
    });
  
})(AJS.$);
</script>
