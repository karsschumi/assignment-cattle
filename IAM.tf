######################
# task Exec IAM Role #
######################
 resource "aws_iam_role" "execution_role" {

     name = format("%s-%s",var.resource_name_prefix,"execution-role")
     assumeassume_role_policy = var.execution_role_assume_policy_json
   
 }

resource "aws_iam_role_policy_attachment" "exec_role_policy_attchment" {

     role = aws_iam_role.execution_role.name
     policy_arn = var.execution_role_managed_policy
   
 }

######################
# task IAM Role #
######################
resource "aws_iam_role" "task_role" {

     name = format("%s-%s",var.resource_name_prefix,"task-role")
     assumeassume_role_policy = var.task_role_assume_policy_json
   
 }

 resource "aws_iam_role_policy_attachment" "exec_role_policy_attchment" {

     role = aws_iam_role.task_role.name
     policy_arn = var.task_role_managed_policy
   
 }