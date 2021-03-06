using System;
using System.Collections;
using UnityEngine;

namespace ARLocation.Utils
{
    public class SmoothMove : MonoBehaviour
    {
        public enum Mode
        {
            Horizontal,
            Full
        }

        [Tooltip("The smoothing factor."), Range(0, 1)]
        public float Epsilon = 0.5f;

        [Tooltip("The Precision."), Range(0, 0.1f)]
        public float Precision = 0.05f;

        public Vector3 Target
        {
            get { return target; }
            set
            {
                target = value;

                if (co != null)
                {
                    StopCoroutine(co);
                }

                co = MoveTo(target);
                StartCoroutine(MoveTo(target));
            }
        }

        [Tooltip("The mode. If set to 'Horizontal', will leave the y component unchanged. Full means the object will move in all 3D coordinates.")]
        public Mode SmoothMoveMode = Mode.Full;

        private Vector3 target;
        private Action onTargetReached;
        private double maxDistance = 300;
        private Transform cameraTransform;
        private IEnumerator co;

        public void Move(Vector3 to, Action callback = null)
        {
            onTargetReached = callback;

            Target = to;
        }

        private IEnumerator MoveTo(Vector3 pTarget)
        {
            if (SmoothMoveMode == Mode.Horizontal)
            {


                Vector2 horizontalPosition = MathUtils.HorizontalVector(transform.position);
                Vector2 horizontalTarget = MathUtils.HorizontalVector(pTarget);

                while (Vector2.Distance(horizontalPosition, horizontalTarget) > Precision)
                {
                    float t = 1.0f - Mathf.Pow(Epsilon, Time.deltaTime);
                    horizontalPosition = Vector3.Lerp(horizontalPosition, horizontalTarget, t);

                    //transform.position = MathUtils.HorizontalVectorToVector3(horizontalPosition, transform.position.y);

                    RoundDistance(MathUtils.HorizontalVectorToVector3(horizontalPosition, transform.position.y));

                    yield return null;
                }

                //transform.position = MathUtils.HorizontalVectorToVector3(horizontalTarget, transform.position.y);
                RoundDistance(MathUtils.HorizontalVectorToVector3(horizontalTarget, transform.position.y));

                onTargetReached!.Invoke();
                onTargetReached = null;
            }
            else
            {
                while (Vector3.Distance(transform.position, pTarget) > Precision)
                {
                    float t = 1.0f - Mathf.Pow(Epsilon, Time.deltaTime);
                    //transform.position = Vector3.Lerp(transform.position, pTarget, t);
                    RoundDistance(Vector3.Lerp(transform.position, pTarget, t));
                    yield return null;
                }

                //transform.position = pTarget;
                RoundDistance(pTarget);

                onTargetReached!.Invoke();
                onTargetReached = null;
            }
        }

         void RoundDistance(Vector3 target)
        {
            float scaleFactor = Vector3.Distance(target, cameraTransform.position) * 0.125f;
            scaleFactor = Mathf.Clamp(scaleFactor, 1, 10000);
            transform.localScale = new Vector3(scaleFactor, scaleFactor, scaleFactor);
            transform.position = target;

        }

        public static SmoothMove AddSmoothMove(GameObject go, float epsilon, double maxDistance = 300)
        {
            var smoothMove = go.AddComponent<SmoothMove>();
            smoothMove.Epsilon = epsilon;
            smoothMove.cameraTransform = Camera.main.transform;
            smoothMove.maxDistance = maxDistance;
            return smoothMove;
        }


        
    }
}
