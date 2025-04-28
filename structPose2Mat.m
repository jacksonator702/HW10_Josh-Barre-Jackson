function model_pose = structPose2Mat(modelStructPose)

orientation = modelStructPose.Pose.Orientation;
position = modelStructPose.Pose.Position;

q = [orientation.W, orientation.X, orientation.Y, orientation.Z];
pos = [position.X, position.Y, position.Z];

R = quat2rotm(q);
model_pose = [R, pos'; 0,0,0,1];
end