--龜樹�?
function c99000023.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,20,2)
	--remove
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(99000023,0))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c99000023.remcost)
	e2:SetTarget(c99000023.remtg)
	e2:SetOperation(c99000023.remop)
	c:RegisterEffect(e2)
	--cannot release
	local ea=Effect.CreateEffect(c)
	ea:SetType(EFFECT_TYPE_SINGLE)
	ea:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	ea:SetRange(LOCATION_MZONE)
	ea:SetCode(EFFECT_UNRELEASABLE_SUM)
	ea:SetValue(1)
	c:RegisterEffect(ea)
	local eb=ea:Clone()
	eb:SetCode(EFFECT_UNRELEASABLE_NONSUM)
	c:RegisterEffect(eb)
end
function c99000023.remcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c99000023.remtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,0,0x1e,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,0,0x1e)
end
function c99000023.remop(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD,nil)
	local g2=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,0,LOCATION_GRAVE,nil)
	local g3=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,0,LOCATION_HAND,nil)
	local g4=Duel.GetDecktopGroup(1-tp,1)
	local sg=Group.CreateGroup()
	if g1:GetCount()>0 and ((g2:GetCount()==0 and g3:GetCount()==0 and g4:GetCount()==0) or Duel.SelectYesNo(tp,aux.Stringid(99000023,1))) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local sg1=g1:Select(tp,1,1,nil)
		Duel.HintSelection(sg1)
		sg:Merge(sg1)
	end
	if g2:GetCount()>0 and ((sg:GetCount()==0 and g3:GetCount()==0 and g4:GetCount()==0) or Duel.SelectYesNo(tp,aux.Stringid(99000023,2))) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local sg2=g2:Select(tp,1,1,nil)
		Duel.HintSelection(sg2)
		sg:Merge(sg2)
	end
	if g3:GetCount()>0 and ((sg:GetCount()==0 and g4:GetCount()==0) or Duel.SelectYesNo(tp,aux.Stringid(99000023,3))) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local sg3=g3:RandomSelect(tp,1,1,nil)
		Duel.HintSelection(sg3)
		sg:Merge(sg3)
	end
	if g4:GetCount()>0 and (sg:GetCount()==0 or Duel.SelectYesNo(tp,aux.Stringid(99000023,4))) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local sg4=g4:Select(tp,1,1,nil)
		sg:Merge(sg4)
	end
	Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
end