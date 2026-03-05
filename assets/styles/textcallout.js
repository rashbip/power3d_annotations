/**
 * Power3D TextCallout Style (js/annotation/styles/textcallout.js)
 * Clean, text-focused callout. Shows title initially.
 */
'use strict';

window.Power3DTextCalloutStyle = (() => {
    function injectStyles() {
        if (document.getElementById('p3d-textcallout-style')) return;
        const style = document.createElement('style');
        style.id = 'p3d-textcallout-style';
        style.textContent = `
            .p3d-callout-el {
                position: absolute;
                pointer-events: auto;
                transform: translate(-50%, -100%);
                z-index: 2100;
                font-family: 'Outfit', sans-serif;
                cursor: pointer;
            }
            .p3d-callout-box {
                background: rgba(255, 255, 255, 0.9);
                border-left: 4px solid #38bdf8;
                border-radius: 4px 12px 12px 4px;
                padding: 8px 16px;
                min-width: 120px;
                max-width: 280px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.15);
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                color: #0f172a;
            }
            .p3d-callout-title {
                margin: 0;
                font-weight: 600;
                font-size: 14px;
            }
            .p3d-callout-details {
                max-height: 0;
                overflow: hidden;
                opacity: 0;
                font-size: 13px;
                line-height: 1.6;
                transition: all 0.4s ease;
                color: #475569;
            }
            .p3d-callout-el.active .p3d-callout-details {
                max-height: 300px;
                opacity: 1;
                margin-top: 10px;
                padding-top: 10px;
                border-top: 1px solid rgba(0,0,0,0.05);
            }
            .p3d-callout-line {
                width: 2px;
                height: 20px;
                background: #38bdf8;
                margin: 0 auto;
            }
        `;
        document.head.appendChild(style);
    }

    function createDom(ann) {
        injectStyles();
        const el = document.createElement('div');
        el.className = 'p3d-callout-el';
        
        el.innerHTML = `
            <div class="p3d-callout-box">
                <p class="p3d-callout-title">${ann.ui.title}</p>
                <div class="p3d-callout-details">
                    ${ann.ui.description || ''}
                    ${ann.ui.more ? `<br><a href="${ann.ui.more}" target="_blank" style="color:#38bdf8;text-decoration:none;font-weight:600;display:block;margin-top:8px;">Open Link →</a>` : ''}
                </div>
            </div>
            <div class="p3d-callout-line"></div>
        `;

        el.onclick = (e) => {
            e.stopPropagation();
            document.querySelectorAll('.p3d-callout-el, .p3d-hotspot-el').forEach(o => {
                if(o !== el) o.classList.remove('active');
            });
            const isActive = el.classList.toggle('active');
            if (isActive && ann.camera && window.Power3DAnnotationEngine) {
                window.Power3DAnnotationEngine.flyTo(ann.camera);
            }
        };

        if (ann.isSelected) el.classList.add('active');
        return el;
    }

    return { createDom };
})();
