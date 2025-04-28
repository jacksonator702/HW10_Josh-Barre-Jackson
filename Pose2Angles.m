function [q_new,robot_joint_names] = Pose2Angles(goal_pose, optns)

r = optns{'rHandle'};
T = goal_pose;
[mat_cur_q,robot_joint_names] = get_current_joint_states(optns);
q_new = r.ik('tool0', T, r.ik_weights, mat_cur_q);



end