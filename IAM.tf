######################
# task Exec IAM Role #
######################
 resource "aws_iam_role" "execution_role" {

     name = format("%s-%s",var.resource_name_prefix,"execution-role")
     assume_role_policy = var.execution_role_assume_policy_json
   
 }

resource "aws_iam_role_policy_attachment" "exec_role_policy_attchment" {
count = length(var.execution_role_managed_policy)
     role = aws_iam_role.execution_role.name
     policy_arn = var.execution_role_managed_policy[count.index]
   
 }

######################
# task IAM Role #
######################
resource "aws_iam_role" "task_role" {

     name = format("%s-%s",var.resource_name_prefix,"task-role")
     assume_role_policy = var.task_role_assume_policy_json
   
 }

 resource "aws_iam_role_policy_attachment" "task_role_policy_attchment" {
 count = length(var.task_role_managed_policy)
     role = aws_iam_role.task_role.name
     policy_arn = var.task_role_managed_policy[count.index]
   
 }