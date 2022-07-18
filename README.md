# facial-landmarks-estimator-on-tao-toolkit
facial-landmarks-estimator-on-tao-toolkit は、NVIDIA TAO TOOLKIT を用いて FacialLandmarksEstimation の AIモデル最適化を行うマイクロサービスです。  

## 動作環境
- NVIDIA 
    - TAO TOOLKIT
- FacialLandmarksEstimation
- Docker
- TensorRT Runtime

## FacialLandmarksEstimationについて
FacialLandmarksEstimation は、画像内の顔の主なランドマークを検出し、顔の形状予測を行うAIモデルです。  
FacialLandmarksEstimation は、特徴抽出にRecombinator Networksを使用しています。

## 動作手順

### engineファイルの生成
FacialLandmarksEstimation のAIモデルをデバイスに最適化するため、 FacialLandmarksEstimation の .etlt ファイルを engine file に変換します。
engine fileへの変換は、Makefile に記載された以下のコマンドにより実行できます。

```
tao-convert:
	docker exec -it faciallandmarks-tao-toolkit tao-converter -k nvidia_tlt -p input_face_images,1x1x80x80,32x1x80x80,32x1x80x80 \
		-t fp16 -d 1,80,80 -e /app/src/faciallandmarks.engine /app/src/faciallandmarks.etlt
```

## 相互依存関係にあるマイクロサービス  
本マイクロサービスで最適化された FacialLandmarksEstimation の AIモデルを Deep Stream 上で動作させる手順は、[facial-landmarks-estimator-on-deepstream](https://github.com/latonaio/facial-landmarks-estimator-on-deepstream)を参照してください。  

## engineファイルについて
engineファイルである faciallandmarks.engine は、[facial-landmarks-estimator-on-deepstream](https://github.com/latonaio/facial-landmarks-estimator-on-deepstream)と共通のファイルであり、本レポジトリで作成した engineファイルを、当該リポジトリで使用しています。  

## 演算について
本レポジトリでは、ニューラルネットワークのモデルにおいて、エッジコンピューティング環境での演算スループット効率を高めるため、FP16(半精度浮動小数点)を使用しています。  
浮動小数点値の変更は、Makefileの以下の部分を変更し、engineファイルを生成してください。

```
tao-convert:
	docker exec -it faciallandmarks-tao-toolkit tao-converter -k nvidia_tlt -p input_face_images,1x1x80x80,32x1x80x80,32x1x80x80 \
		-t fp16 -d 1,80,80 -e /app/src/faciallandmarks.engine /app/src/faciallandmarks.etlt 

```