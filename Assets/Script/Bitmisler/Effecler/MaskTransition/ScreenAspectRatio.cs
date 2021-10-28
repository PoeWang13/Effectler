using TMPro;
using UnityEngine;
using UnityEngine.UI;
using System.Collections.Generic;

public class ScreenAspectRatio : MonoBehaviour
{
    [Header("Script Atamaları")]
    public bool isStarting;
    public Image maskTransition;
    public GameObject target;
    private RectTransform canvas;
    private float radius;
    private float counter;
    private float screen_Widht;
    private float screen_Height;

    private void Start()
    {
        GetCharacterPosition();
    }
    private void Update()
    {
        counter += Time.deltaTime;
        if (counter > 0.5f)
        {
            if (isStarting)
            {
                if (radius < 1)
                {
                    radius += Time.deltaTime;
                    maskTransition.material.SetFloat("Vector1_Radius", radius);
                }
            }
            else
            {
                if (radius > 0)
                {
                    radius -= Time.deltaTime;
                    maskTransition.material.SetFloat("Vector1_Radius", radius);
                }
            }
        }
    }
    private void GetCharacterPosition()
    {
        if (isStarting)
        {
            radius = 0;
        }
        else
        {
            radius = 1;
        }
        maskTransition.material.SetFloat("Vector1_Radius", radius);
        Vector3 screenPos = Camera.main.WorldToScreenPoint(target.transform.position);

        float characterScreenWidht = 0;
        float characterScreenHeight = 0;
        canvas = GetComponent<RectTransform>();
        screen_Widht = Screen.width;
        screen_Height = Screen.height;
        if (screen_Widht < screen_Height)
        {
            // Portrait yani dikey
            maskTransition.rectTransform.sizeDelta = new Vector2(canvas.rect.height, canvas.rect.height);
            
            float newScreenPosX = screenPos.x + (screen_Height - screen_Widht) / 2;
            characterScreenWidht = (newScreenPosX * 100) / screen_Height;
            characterScreenWidht /= 100;
            
            characterScreenHeight= (screenPos.y * 100) / screen_Height;
            characterScreenHeight /= 100;
        }
        else
        {
            maskTransition.rectTransform.sizeDelta = new Vector2(canvas.rect.width, canvas.rect.width);
            
            float newScreenPosY = screenPos.y + (screen_Widht - screen_Height) / 2;
            characterScreenWidht = (screenPos.x * 100) / screen_Widht;
            characterScreenWidht /= 100;
            
            characterScreenHeight = (newScreenPosY * 100) / screen_Widht;
            characterScreenHeight /= 100;
        }
        maskTransition.material.SetFloat("Vector1_Center_X", characterScreenWidht);
        maskTransition.material.SetFloat("Vector1_Center_Y", characterScreenHeight);
    }
}