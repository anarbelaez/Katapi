[1mdiff --git a/app/views/users/activity.html.erb b/app/views/users/activity.html.erb[m
[1mindex 4ec7f49..2219566 100644[m
[1m--- a/app/views/users/activity.html.erb[m
[1m+++ b/app/views/users/activity.html.erb[m
[36m@@ -1,11 +1,11 @@[m
[31m-<style>[m
[32m+[m[32m<%# <style>[m
 @media screen and (min-width: 800px) {[m
   .modal-dialog {[m
     margin-right: 0 !important;[m
     margin-top: 0 !important;[m
   }[m
 }[m
[31m-</style>[m
[32m+[m[32m</style> %>[m
 <% if @user.goals.present? %>[m
 <div class="row g-4 mb-5">[m
   <div class="col-md-8 order-1 order-md-0">[m
