Shader "Custom/Charpter5-SimpleShader"
{
	Properties
	{
		_Color("Color Tint", Color) = (1.0, 1.0, 1.0, 1.0)
	}
		SubShader
	{
		Pass{
			CGPROGRAM
			// 告诉unity哪个函数包含了顶点/片元着色器的代码
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			// 这边需要定义一个相同的名字来接property中的属性变量
			fixed4 _Color;
			// 使用一个结构体来定义顶点着色器的输入
			// 这些POSITION， TANGENT， NORMAL是由mesh render提供的，就是一组三角面片
			struct a2v{
				// 用模型的顶点去充填vertex变量
				float4 vertex : POSITION;
				// 用normal充填normal变量
				float3 normal : NORMAL;
				// 用第一套纹理来充填texcoord
				float4 texcoord : TEXCOORD0;
			};
			

			// 使用一个结构体来定义顶点着色器的输出
			struct v2f {
				float4 pos : SV_POSITION;
				float3 color : COLOR0;
			};

			//// v : POSITION, 将模型的顶点坐标作为输入
			//// SV_POSITION定义函数的输出是裁剪空间中的坐标
			//float4 vert(a2v v) : SV_POSITION{
			//	return UnityObjectToClipPos(v.vertex);
			//};

			// 这边不需要回传任何的POSITION之类的
			v2f vert(a2v v){
				v2f o; 
				o.pos = UnityObjectToClipPos(v.vertex);
				// v.normal包含了顶点的法线，分量在 -1， 1
				// 存储到o.color中传递给片元着色器
				o.color = v.normal * 0.5 + fixed3(0.5, 0.5, 0.5);
				return o;
			}

			// v2f 是从vertex shader里面传过来的
			fixed4 frag(v2f i) : SV_Target{
				fixed3 c = i.color;
				c *= _Color.rgb;
				return fixed4(c, 0.6);
			}
			
			ENDCG
	
		}

    }
    FallBack "Diffuse"
}
