folder=1
for video in {0..20}
do
	notebook_name=~/BC-actionpred-seg/05-yolo-comb-masks.ipynb
	outname=~/BC-actionpred-seg/Data/papermill-combmasks-v1/05-yolo-comb-masks-f${folder}-v${video}.ipynb

	echo $folder
	echo $video

	echo $notebook_name
	echo $outname

	papermill $notebook_name $outname -p folder $folder -p video $video --autosave-cell-every 5 --progress-bar
done