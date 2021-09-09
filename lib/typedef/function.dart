/*
 * @Author: XingWei 
 * @Date: 2021-05-12 11:24:15 
 * @Last Modified by: XingWei
 * @Last Modified time: 2021-05-12 11:58:47
 */
///无参数请求回调
typedef ParamVoidCallback = dynamic Function();

///回调一个参数
typedef ParamSingleCallback<D> = dynamic Function(D data);

///回到俩个参数
typedef ParamTwiceCallback<O, T> = dynamic Function(O dataOne, T dataTwo);

///回调三个参数
typedef ParamThreeCallback<O, T, K> = dynamic Function(
    O dataOne, T dataTwo, K threeData);
