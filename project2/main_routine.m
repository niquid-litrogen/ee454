function main_routine(joint_dataset, vue2, vue4)

joint_dists = joint_distances(joint_dataset, vue2, vue4);
metrics = generate_metrics(joint_dists);


metrics_titles = ["Mean" "Std Dev" "Min" "Median" "Max"];

filename = 'metrics_table.xlsx';
writematrix(metrics_titles, filename, 'Range', 'A1');
writematrix(metrics, filename, 'Range', 'A2');

end