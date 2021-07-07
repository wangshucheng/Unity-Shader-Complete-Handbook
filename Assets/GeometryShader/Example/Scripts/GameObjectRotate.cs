using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class GameObjectRotate : MonoBehaviour
{
    public enum SelfAxis
    {
        X,
        Y,
        Z,
    }

    public bool isOpen = true;                    //是否开始旋转
    public int speed = 2;                         //旋转速度
    public SelfAxis currAxis = SelfAxis.Y;        //旋转轴向

    void Update()
    {
        if (isOpen)
        {
            RoateAxisOfSelf(currAxis, speed);
        }
    }


    /// <summary>
    /// 让物体围绕物体自身旋转
    /// </summary>
    private void RoateAxisOfSelf(SelfAxis selfAxis = SelfAxis.Y,int speed = 2)
    {
        switch (selfAxis)
        {
            case SelfAxis.X:
                this.transform.Rotate(new Vector3(1 * Time.deltaTime * speed, 0, 0));
                break;
            case SelfAxis.Y:
                this.transform.Rotate(new Vector3(0, 1 * Time.deltaTime * speed, 0));
                break;
            case SelfAxis.Z:
                this.transform.Rotate(new Vector3(0,0, 1 * Time.deltaTime * speed));
                break;
            default:
                this.transform.Rotate(new Vector3(0, 1 * Time.deltaTime * speed, 0));
                break;
        }
    }
}
